package br.edu.ifsp.bra.tarefa;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public Tarefa tarefa() {
        return new TarefaImpl();
    }
}