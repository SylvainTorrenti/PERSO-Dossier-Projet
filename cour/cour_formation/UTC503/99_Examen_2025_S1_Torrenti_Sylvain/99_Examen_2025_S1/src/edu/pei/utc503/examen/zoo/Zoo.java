package edu.pei.utc503.examen.zoo;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.function.Predicate;

public class Zoo {

	/**
	 * Liste des animaux du Zoo
	 */
	public List<Animal> animaux;

	public Zoo() {
		animaux = new ArrayList<>();
	}

	/**
	 * Ajout d'un animal au zoo
	 * 
	 * @param unAnimal
	 */
	public void ajouterAnimal(Animal unAnimal) {
		animaux.add(unAnimal);
	}
	/**
	 * Ajout d'un chien au zoo
	 * 
	 * @param unChien !!!!!INUTILE!!!!!
	 */
//	public void ajouterChien(Chien unChien) {
//		animaux.add(unChien);
//	}

	/**
	 * Ajout d'un chat au zoo
	 * 
	 * @param unChat !!!!!INUTILE!!!!!
	 */
//	public void ajouterChat(Chat unChat) {
//		animaux.add(unChat);		
//	}

	/**
	 * Affiche le nom de tous les animaux du zoo
	 */
	public void afficherAnimaux() {
		for (Animal animal : animaux) {
			System.out.println(animal.getNom());
		}
	}

	/**
	 * Affiche les nom des animaux du zoo qui respectent la condition du filtre
	 * 
	 * @param filtre
	 */
	public void afficherAnimaux(Predicate<Animal> filtre) {

	}

	/**
	 * Affiche les noms animaux du zoo obtenus en utilisant le nommeur
	 * 
	 * @param nommeur
	 */
//	public void afficherAnimaux(Function<Animal, String> nommeur) {
//
//		
//	}

	/**
	 * Demande à chacun des animaux du zoo de parler
	 */
	public void faireParlerTousLesAnimaux() {
		for (Animal animal : animaux) {
			animal.parler();
		}
	}

}
