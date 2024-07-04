package com.example;

import java.util.ArrayList;
import java.util.List;

abstract class Animal {
    protected String name;
    protected int age;
    protected List<String> commands;

    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
        this.commands = new ArrayList<>();
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public List<String> getCommands() {
        return commands;
    }

    public void addCommand(String command) {
        commands.add(command);
    }

    public abstract String getType();
}

abstract class Pet extends Animal {
    public Pet(String name, int age) {
        super(name, age);
    }
}

abstract class PackAnimal extends Animal {
    public PackAnimal(String name, int age) {
        super(name, age);
    }
}

class Dog extends Pet {
    public Dog(String name, int age) {
        super(name, age);
    }

    @Override
    public String getType() {
        return "Dog";
    }
}

class Cat extends Pet {
    public Cat(String name, int age) {
        super(name, age);
    }

    @Override
    public String getType() {
        return "Cat";
    }
}

class Hamster extends Pet {
    public Hamster(String name, int age) {
        super(name, age);
    }

    @Override
    public String getType() {
        return "Hamster";
    }
}

class Horse extends PackAnimal {
    public Horse(String name, int age) {
        super(name, age);
    }

    @Override
    public String getType() {
        return "Horse";
    }
}

class Camel extends PackAnimal {
    public Camel(String name, int age) {
        super(name, age);
    }

    @Override
    public String getType() {
        return "Camel";
    }
}

class Donkey extends PackAnimal {
    public Donkey(String name, int age) {
        super(name, age);
    }

    @Override
    public String getType() {
        return "Donkey";
    }
}
