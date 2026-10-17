<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Grocery Store</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f4f6f9; }
        h2, h3 { color: #2c3e50; }
        .container { display: flex; gap: 20px; }
        .catalog { flex: 2; }
        .admin-panel { flex: 1; background: white; padding: 20px; border-radius: 5px; height: fit-content; border-top: 4px solid #2c3e50; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #27ae60; color: white; }
        input, select, button { width: 100%; padding: 8px; margin: 5px 0; box-sizing: border-box; }
        .btn-add { background-color: #2c3e50; color: white; border: none; cursor: pointer; font-weight: bold; }
        .btn-buy { background-color: #e67e22; color: white; border: none; cursor: pointer; padding: 8px; font-weight: bold; border-radius: 3px; }
        .btn-buy:hover { background-color: #d35400; }
        .out-of-stock { color: red; font-weight: bold; }
    </style>
</head>
<body>

    <h2>🛒 FreshCart — Online Grocery Store</h2>

    <div class="container">
        <!-- CUSTOMER VIEW: STORE CATALOG -->
        <div class="catalog">
            <h3>Customer View: Buy Groceries</h3>
            <table>
                <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th>Available Stock</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Product> products = (List<Product>) request.getAttribute("productList");
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                %>
                <tr>
                    <td><strong><%= p.getName() %></strong><br><small><%= p.getUnitType() %></small></td>
                    <td>₹<%= p.getPrice() %></td>
                    <td>
                        <% if (p.getStock() > 0) { %>
                            <%= p.getStock() %> in stock
                        <% } else { %>
                            <span class="out-of-stock">Out of Stock!</span>
                        <% } %>
                    </td>
                    <td>
                        <% if (p.getStock() > 0) { %>
                            <form action="products" method="post" style="margin: 0;">
                                <input type="hidden" name="action" value="buy">
                                <input type="hidden" name="productId" value="<%= p.getId() %>">
                                <button type="submit" class="btn-buy">Buy 1 Item</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="4">Store is currently empty.</td></tr>
                <% } %>
            </table>
        </div>

        <!-- ADMIN VIEW: ADD INVENTORY -->
        <div class="admin-panel">
            <h3>Admin: Add Inventory</h3>
            <form action="products" method="post">
                <input type="hidden" name="action" value="add">
                <input type="text" name="name" placeholder="Item Name" required>
                <select name="categoryId">
                    <option value="1">Fruits & Vegetables</option>
                    <option value="2">Dairy & Bakery</option>
                    <option value="3">Beverages</option>
                </select>
                <input type="number" step="0.01" name="price" placeholder="Price (INR)" required>
                <input type="number" name="stock" placeholder="Stock Quantity" required>
                <input type="text" name="unitType" placeholder="Unit (e.g. kg, pack)" required>
                <button type="submit" class="btn-add">+ Add to Store</button>
            </form>
        </div>
    </div>

</body>
</html>