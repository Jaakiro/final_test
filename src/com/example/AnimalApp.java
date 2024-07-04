package com.example;

import java.util.Scanner;

public class AnimalApp {
    public static void main(String[] args) {
        AnimalManager manager = new AnimalManager();
        Scanner scanner = new Scanner(System.in);

        try (Counter counter = new Counter()) {
            while (true) {
                System.out.println("1. Add new animal");
                System.out.println("2. Show animal commands");
                System.out.println("3. Train animal");
                System.out.println("4. Exit");
                System.out.print("Choose an option: ");
                int choice = scanner.nextInt();
                scanner.nextLine();  // Consume newline

                switch (choice) {
                    case 1:
                        System.out.print("Enter animal type (Dog/Cat/Hamster/Horse/Camel/Donkey): ");
                        String type = scanner.nextLine();
                        System.out.print("Enter animal name: ");
                        String name = scanner.nextLine();
                        System.out.print("Enter animal age: ");
                        int age = scanner.nextInt();
                        scanner.nextLine();  // Consume newline

                        if (type.isEmpty() || name.isEmpty() || age <= 0) {
                            System.out.println("All fields must be filled correctly.");
                            continue;
                        }

                        try {
                            Animal animal = AnimalFactory.createAnimal(type, name, age);
                            manager.addAnimal(animal);
                            counter.add();
                            System.out.println("Animal added: " + animal.getName());
                        } catch (IllegalArgumentException e) {
                            System.out.println(e.getMessage());
                        }
                        break;

                    case 2:
                        System.out.print("Enter animal name: ");
                        String searchName = scanner.nextLine();
                        Animal animal = manager.getAnimalByName(searchName);
                        if (animal != null) {
                            manager.showCommands(animal);
                        } else {
                            System.out.println("Animal not found");
                        }
                        break;

                    case 3:
                        System.out.print("Enter animal name: ");
                        searchName = scanner.nextLine();
                        animal = manager.getAnimalByName(searchName);
                        if (animal != null) {
                            System.out.print("Enter new command: ");
                            String command = scanner.nextLine();
                            manager.trainAnimal(animal, command);
                        } else {
                            System.out.println("Animal not found");
                        }
                        break;

                    case 4:
                        System.out.println("Exiting the program.");
                        return;

                    default:
                        System.out.println("Invalid option. Please try again.");
                        break;
                }
            }
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
