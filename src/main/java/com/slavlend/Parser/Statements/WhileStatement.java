package com.slavlend.Parser.Statements;

import com.slavlend.App;
import com.slavlend.Compiler.Compiler;
import com.slavlend.Parser.Expressions.Expression;
import com.slavlend.Parser.Address;
import lombok.Getter;
import lombok.Setter;
import com.slavlend.Vm.Instructions.*;

import java.util.ArrayList;

/*
Вайл стэйтмент - цикл
 */
@Getter
public class WhileStatement implements Statement {
    // тело
    private final ArrayList<Statement> statements = new ArrayList<>();
    // логическое выражение
    private final Expression expression;
    // адресс
    @Setter
    private Address address = App.parser.address();

    public void add(Statement statement) {
        statements.add(statement);
    }

    // адресс
    @Override
    public Address address() {
        return address;
    }

    @Override
    public void compile() {
        VmInstrLoop loop = new VmInstrLoop(address.convert());
        Compiler.code.visitInstr(loop);
        Compiler.code.startWrite(loop);
        VmInstrIf ifInstr = new VmInstrIf(address.convert());
        Compiler.code.visitInstr(ifInstr);
        Compiler.code.startWrite(ifInstr);
        ifInstr.setWritingConditions(true);
        expression.compile();
        ifInstr.setWritingConditions(false);
        for (Statement s : statements) {
            s.compile();
        }
        Compiler.code.endWrite();
        VmInstrIf elseInstr = new VmInstrIf(address.convert());
        Compiler.code.startWrite(elseInstr);
        elseInstr.setWritingConditions(true);
        elseInstr.visitInstr(new VmInstrPush(address.convert(), true));
        elseInstr.setWritingConditions(false);
        elseInstr.visitInstr(new VmInstrLoopEnd(address.convert(), false));
        ifInstr.setElse(elseInstr);
        Compiler.code.endWrite();
        Compiler.code.endWrite();
    }

    // конструктор
    public WhileStatement(Expression e) {
        this.expression = e;
    }
}
