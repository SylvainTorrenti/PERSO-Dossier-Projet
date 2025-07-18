package edu.pei.utc503.examen.zoo;

public abstract class Animal {
    /**
     * Nom de l'animal
     */
	private String nom;

    public Animal(String nom) {
        this.nom = nom;
    }

    /**
     * L'animal parle en écrivant dans la console
     */
    public abstract void parler();

    /**
     * L'animal parle à un autre animal
     * @param interlocuteur l'interlocuteur
     */
    public void parler(Animal interlocuteur) {
    	parler();
    	System.out.println( " à " + interlocuteur.nom);
    	
    	
    }

	public String getNom() {
		return nom;
	}


}