package edu.pei.utc503.examen.zoo;

/**
 * Un Chat 
 */
public class Chat extends Animal {
    
	public Chat(String nom) {
        super(nom);
    }

	public void parler() {
        System.out.println(this.getNom() + " dit : Miaou !");
    }

}
