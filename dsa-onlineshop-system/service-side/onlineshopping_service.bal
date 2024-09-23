import ballerina/http;

listener http:Listener ep = new (9090);

type ProductItem record {|
    readonly string id;
    string name;
    string description;
    decimal price;
    int quantity;
    string status;
|};

type CartItemInfo record {|
    string product_id;
    int quantity;
|};

type CartInfo record {|
    readonly string user_id;
    CartItemInfo[] items;
|};

type UserInfo record {|
    readonly string id;
    string name;
    string email;
|};

table<ProductItem> key(id) productsTable = table [];
table<CartInfo> key(user_id) cartsTable = table [];
table<UserInfo> key(id) usersTable = table [];

service /api on ep {
    resource function post products(@http:Payload ProductItem product) returns http:Created|error {
        productsTable.add(product);
        return http:CREATED;
    }

    resource function get products/[string id]() returns ProductItem|http:NotFound {
        ProductItem? product = productsTable[id];
        if product is ProductItem {
            return product;
        }
        return http:NOT_FOUND;
    }

    resource function put products/[string id](@http:Payload ProductItem product) returns ProductItem|http:NotFound {
        ProductItem? existingProduct = productsTable[id];
        if existingProduct is ProductItem {
            _ = productsTable.put(product);
            return product;
        }
        return http:NOT_FOUND;
    }

    resource function delete products/[string id]() returns http:NoContent|http:NotFound {
        ProductItem? removedProduct = productsTable.remove(id);
        if removedProduct is ProductItem {
            return http:NO_CONTENT;
        }
        return http:NOT_FOUND;
    }

    resource function get products() returns ProductItem[] {
        return productsTable.toArray();
    }

    resource function post carts(@http:Payload CartInfo cart) returns http:Created|error {
        cartsTable.add(cart);
        return http:CREATED;
    }

    resource function post orders(@http:Payload record {|string user_id;|} payload) returns http:Created|error {
        // Implement order processing logic here
        return http:CREATED;
    }

    resource function post users(@http:Payload UserInfo user) returns http:Created|error {
        usersTable.add(user);
        return http:CREATED;
    }
}
