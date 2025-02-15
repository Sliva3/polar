package com.slavlend;

import com.slavlend.Parser.Address;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/*
Загрузчик класса
 */
public class PolarClassLoader extends ClassLoader {
    // Путь к классу
    private final String classPath;

    public Class<?> defineJvmClass(String className) {
        byte[] classData = loadClassData();
        if (classData == null) {
            return null;
        }
        return defineClass(className.replace(".class", ""), classData, 0, classData.length);
    }

    private byte[] loadClassData() {
        try(FileInputStream inputStream = new FileInputStream(classPath);
            ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            byte[] bufferOfBytes = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(bufferOfBytes)) != -1) {
                baos.write(bufferOfBytes, 0, bytesRead);
            }
            return baos.toByteArray();
        } catch (FileNotFoundException e) {
            PolarLogger.exception("File not found exception: " + e.getMessage(), new Address(-1));
        } catch (IOException e) {
            PolarLogger.exception("IOException: " + e.getMessage(), new Address(-1));
        }
        return null;
    }

    public PolarClassLoader(String classPath) {
        this.classPath = classPath;
    }
}
