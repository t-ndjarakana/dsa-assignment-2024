import ballerina/http;
import ballerina/io;

http:Client shoppingClient = check new ("http://localhost:9090/api");

public function main() returns error? {
    while true {
        printMenu();
        string choice = io:readln("Enter your choice from the below list: ");
        io:println("======================================");

        match choice {
            "1" => {
                check addProduct();
            }
            "2" => {
                check updateProduct();
            }
            "3" => {
                check removeProduct();
            }
            "4" => {
                check getProduct();
            }
            "5" => {
                check addToCart();
            }
            "6" => {
                check placeOrder();
            }
            "7" => {
                check createUser();
            }
            "8" => {
                check listProducts();
            }
            "9" => {
                io:println("Thank you for using our Online Shopping System. Goodbye!");
                return;
            }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }
        io:println("\nPress Enter to continue...");
        _ = io:readln();
    }
}
// Function to print the main menu of the NUST Online Shopping System.
function printMenu() {
    io:println("======================================");
    io:println("      NUST Online Shopping System");
    io:println("======================================");
    io:println("1. Add Product");
    io:println("2. Update Product");
    io:println("3. Remove Product");
    io:println("4. Get Product");
    io:println("5. Add to Cart");
    io:println("6. Place Order");
    io:println("7. Create User");
    io:println("8. List Products");
    io:println("9. Exit");
    io:println("======================================");
}

function addProduct() returns error? {
    record {|
        readonly string id;
        string name;
        string description;
        decimal price;
        int quantity;
        string status;
    |} product = {
        id: io:readln("Enter product ID: "),
        name: io:readln("Enter product name: "),
        description: io:readln("Enter product description: "),
        price: check decimal:fromString(io:readln("Enter product price: ")),
        quantity: check int:fromString(io:readln("Enter product quantity: ")),
        status: io:readln("Enter product status (Available/Out of Stock): ")
    };

    http:Response response = check shoppingClient->/products.post(product);
    io:println("Product added successfully. Status: ", response.statusCode);
}

function updateProduct() returns error? {
    string id = io:readln("Enter product ID to update: ");
    record {|
        readonly string id;
        string name;
        string description;
        decimal price;
        int quantity;
        string status;
    |} product = {
        id: id,
        name: io:readln("Enter new product name: "),
        description: io:readln("Enter new product description: "),
        price: check decimal:fromString(io:readln("Enter new product price: ")),
        quantity: check int:fromString(io:readln("Enter new product quantity: ")),
        status: io:readln("Enter new product status (Available/Out of Stock): ")
    };

    http:Response response = check shoppingClient->/products/[id].put(product);
    io:println("Product updated successfully. Status: ", response.statusCode);
}

function removeProduct() returns error? {
    string id = io:readln("Enter product ID to remove: ");
    http:Response response = check shoppingClient->/products/[id].delete();
    io:println("Product removed successfully. Status: ", response.statusCode);
}

function getProduct() returns error? {
    string id = io:readln("Enter product ID to get: ");
    json product = check shoppingClient->/products/[id];
    io:println("Product found: ", product.toJsonString());
}

function addToCart() returns error? {
    record {|
        readonly string user_id;
        record {|
            string product_id;
            int quantity;
        |}[] items;
    |} cart = {
        user_id: io:readln("Enter user ID: "),
        items: [
            {
                product_id: io:readln("Enter product ID to add to cart: "),
                quantity: check int:fromString(io:readln("Enter quantity: "))
            }
        ]
    };

    http:Response response = check shoppingClient->/carts.post(cart);
    io:println("Product added to cart. Status: ", response.statusCode);
}

function placeOrder() returns error? {
    string user_id = io:readln("Enter user ID to place order: ");
    http:Response response = check shoppingClient->/orders.post({user_id: user_id});
    io:println("Order placed successfully. Status: ", response.statusCode);
}

function createUser() returns error? {
    record {|
        readonly string id;
        string name;
        string email;
    |} user = {
        id: io:readln("Enter user ID: "),
        name: io:readln("Enter user name: "),
        email: io:readln("Enter user email: ")
    };

    http:Response response = check shoppingClient->/users.post(user);
    io:println("User created successfully. Status: ", response.statusCode);
}

function listProducts() returns error? {
    json[] products = check shoppingClient->/products;
    io:println("Products:");
    foreach var product in products {
        io:println("- ", product.toJsonString());
    }
}
