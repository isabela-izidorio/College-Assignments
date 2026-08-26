package br.edu.ifsp.bra.tarefa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Programa {
    private Tarefa tarefa;

    @Autowired
    public Programa(Tarefa tarefa){
        this.tarefa = tarefa;
    }

    public void executar(){
        this.tarefa.executar();;
    }
}