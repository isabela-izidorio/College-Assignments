package br.edu.ifsp.bra.tarefa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class TarefaApplication implements CommandLineRunner {
	private Programa programa;

	@Autowired
	public TarefaApplication(Programa programa){
		this.programa = programa;
	}

	@Override
	public void run(String... args) throws Exception {
		this.programa.executar();
		
	}
	
	public static void main(String[] args) {
		SpringApplication.run(TarefaApplication.class, args);
	}
}