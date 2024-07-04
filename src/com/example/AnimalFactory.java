package com.example;

public class AnimalFactory {
    public static Animal createAnimal(String type, String name, int age) {
        switch (type.toLowerCase()) {
            case "dog":
                return new Dog(name, age);
            case "cat":
                return new Cat(name, age);
            case "hamster":
                return new Hamster(name, age);
            case "horse":
                return new Horse(name, age);
            case "camel":
                return new Camel(name, age);
            case "donkey":
                return new Donkey(name, age);
            default:
                throw new IllegalArgumentException("Unknown animal type: " + type);
        }
    }
}
