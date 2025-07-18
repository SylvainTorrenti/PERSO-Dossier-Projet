package edu.pei.utc503.examen.zoo;

/**
 * Un Chien 
 */
public class Chien extends Animal {
    
	public Chien(String nom) {
        super(nom);
    }

    public void parler() {
    	System.out.println(this.getNom() + " dit : Ouaf !");
    }
}
