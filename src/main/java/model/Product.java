package model;

public class Product {
    private int id;
    private String name;
    private int categoryId;
    private double price;
    private int stock;
    private String unitType;

    public Product(int id, String name, int categoryId, double price, int stock, String unitType) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.price = price;
        this.stock = stock;
        this.unitType = unitType;
    }

    public Product(String name, int categoryId, double price, int stock, String unitType) {
        this(0, name, categoryId, price, stock, unitType);
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public int getCategoryId() { return categoryId; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }
    public String getUnitType() { return unitType; }
}