package com.example;

import java.util.ArrayList;
import java.util.List;

class AnimalManager {
    private List<Animal> animals;

    public AnimalManager() {
        this.animals = new ArrayList<>();
    }

    public void addAnimal(Animal animal) {
        animals.add(animal);
    }

    public Animal getAnimalByName(String name) {
        for (Animal animal : animals) {
            if (animal.getName().equalsIgnoreCase(name)) {
                return animal;
            }
        }
        return null;
    }

    public void showCommands(Animal animal) {
        System.out.println("Commands for " + animal.getName() + ": " + animal.getCommands());
    }

    public void trainAnimal(Animal animal, String command) {
        animal.addCommand(command);
        System.out.println(animal.getName() + " has learned the command: " + command);
    }
}
