package edu.pei.utc503.examen.zoo;

import java.util.function.Predicate;

public class Main {

	public static void main(String[] args) {

		Zoo monZoo = new Zoo();

		Chien pif = new Chien("Pif");
		Chien medor = new Chien("Medor");
		Chat minou = new Chat("Minou");
		Chien tifon = new Chien("Tifon");
		Chien sultan = new Chien("Sultan");
		Chat felix = new Chat("Felix");
		Chat tilou = new Chat("Tilou");
		
		monZoo.ajouterAnimal(pif);
		monZoo.ajouterAnimal(medor);
		monZoo.ajouterAnimal(minou);
		monZoo.ajouterAnimal(tifon);
		monZoo.ajouterAnimal(sultan);
		monZoo.ajouterAnimal(felix);
		monZoo.ajouterAnimal(tilou);
		
//		System.out.println("=== Les animaux s'expriment ========");
//		pif.parler();
//		tifon.parler();
//		medor.parler();
//		tilou.parler();
//
//		System.out.println("=== Tifon parle à Tilou ========");
//		tifon.parler(tilou);
//		System.out.println("=== Tilou répond à Tifon ========");
//		tilou.parler(tifon);
//
//		System.out.println("=== Tous les animaux du zoo s'expriment ========");
//		monZoo.faireParlerTousLesAnimaux();
//		
//		System.out.println("=== Tous les animaux ========");
//		monZoo.afficherAnimaux();
		
//		System.out.println("=== Tous les animaux dont le nom contient i ========");
//		monZoo.afficherAnimaux((Predicate<Animal>) a -> a.getNom().contains("i"));
//		
//		System.out.println("=== Tous les animaux avec leur nom entre accolades ========");
//		monZoo.afficherAnimaux( (Function<Animal, String>) a -> "{" + a.nom + "}");
		
	}
	
	
}
