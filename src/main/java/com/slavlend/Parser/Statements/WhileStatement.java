package com.slavlend.Parser.Statements;

import com.slavlend.App;
import com.slavlend.Compiler.Compiler;
import com.slavlend.Parser.Expressions.Expression;
import com.slavlend.Parser.Operator;
import com.slavlend.Parser.Address;
import com.slavlend.Vm.Instructions.*;
import lombok.Getter;

import java.util.ArrayList;

/*
Вайл стэйтмент - цикл
 */
@Getter
public class WhileStatement implements Statement {
    // тело
    private final ArrayList<Statement> statements = new ArrayList<>();
    // кодишены
    private final ArrayList<Expression> conditions;
    // адресс
    private final Address address = App.parser.address();

    public void add(Statement statement) {
        statements.add(statement);
    }

    // копирование
    @Override
    public Statement copy() {
        WhileStatement _copy = new WhileStatement(conditions);

        for (Statement statement : statements) {
            _copy.add(statement.copy());
        }

        return _copy;
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
        compileConditions();
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

    private void compileConditions() {
        int conditionsAmount = 0;
        for (Expression cond : conditions) {
            cond.compile();
            if (conditionsAmount+1 == 2) {
                Compiler.code.visitInstr(new VmInstrComputeConds(address.convert()));
            }
            else {
                conditionsAmount += 1;
            }
        }
    }

    // конструктор
    public WhileStatement(ArrayList<Expression> _conditions) {
        this.conditions = _conditions;
    }
}
