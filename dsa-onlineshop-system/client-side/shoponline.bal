import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string ONLINE_SHOPPING_DESC = "0A156F6E6C696E655F73686F7070696E672E70726F746F120E4F6E6C696E6553686F7070696E671A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F227F0A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512100A03736B751804200128095203736B7512160A067374617475731805200128095206737461747573225E0A0F50726F64756374526573706F6E736512180A076D65737361676518012001280952076D65737361676512310A0770726F6475637418022001280B32172E4F6E6C696E6553686F7070696E672E50726F64756374520770726F6475637422310A044361727412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522270A0C43617274526573706F6E736512170A07757365725F69641801200128095206757365724964222C0A11706C6163654F726465725265717565737412170A07757365725F6964180120012809520675736572496422280A0D4F72646572526573706F6E736512170A07757365725F69641801200128095206757365724964223E0A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512120A04726F6C651803200128095204726F6C6522420A14557365724372656174696F6E526573706F6E7365122A0A05757365727318012003280B32142E4F6E6C696E6553686F7070696E672E557365725205757365727332ED040A0E6F6E6C696E6553686F7070696E6712460A0A61646450726F6475637412172E4F6E6C696E6553686F7070696E672E50726F647563741A1F2E4F6E6C696E6553686F7070696E672E50726F64756374526573706F6E736512490A0D75706461746550726F6475637412172E4F6E6C696E6553686F7070696E672E50726F647563741A1F2E4F6E6C696E6553686F7070696E672E50726F64756374526573706F6E7365124E0A0D72656D6F766550726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1F2E4F6E6C696E6553686F7070696E672E50726F64756374526573706F6E7365124A0A156C697374417661696C61626C6550726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A172E4F6E6C696E6553686F7070696E672E50726F647563743001124E0A0D73656172636850726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1F2E4F6E6C696E6553686F7070696E672E50726F64756374526573706F6E7365123F0A09616464546F4361727412142E4F6E6C696E6553686F7070696E672E436172741A1C2E4F6E6C696E6553686F7070696E672E43617274526573706F6E7365124E0A0A706C6163654F7264657212212E4F6E6C696E6553686F7070696E672E706C6163654F72646572526571756573741A1D2E4F6E6C696E6553686F7070696E672E4F72646572526573706F6E7365124B0A0B637265617465557365727312142E4F6E6C696E6553686F7070696E672E557365721A242E4F6E6C696E6553686F7070696E672E557365724372656174696F6E526573706F6E73652801620670726F746F33";

public isolated client class onlineShoppingClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ONLINE_SHOPPING_DESC);
    }

isolated remote function addProduct(Product|ContextProduct req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function addProductContext(Product|ContextProduct req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function updateProduct(Product|ContextProduct req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function updateProductContext(Product|ContextProduct req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function removeProduct(string|wrappers:ContextString req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function removeProductContext(string|wrappers:ContextString req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function searchProduct(string|wrappers:ContextString req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function searchProductContext(string|wrappers:ContextString req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function addToCart(Cart|ContextCart req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        Cart message;
        if req is ContextCart {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function addToCartContext(Cart|ContextCart req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        Cart message;
        if req is ContextCart {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function placeOrder(placeOrderRequest|ContextPlaceOrderRequest req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        placeOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function placeOrderContext(placeOrderRequest|ContextPlaceOrderRequest req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        placeOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("OnlineShopping.onlineShopping/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("OnlineShopping.onlineShopping/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }

    isolated remote function listAvailableProducts() returns stream<Product, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("OnlineShopping.onlineShopping/listAvailableProducts", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ProductStream outputStream = new ProductStream(result);
        return new stream<Product, grpc:Error?>(outputStream);
    }

    isolated remote function listAvailableProductsContext() returns ContextProductStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("OnlineShopping.onlineShopping/listAvailableProducts", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ProductStream outputStream = new ProductStream(result);
        return {content: new stream<Product, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveUserCreationResponse() returns UserCreationResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UserCreationResponse>payload;
        }
    }

    isolated remote function receiveContextUserCreationResponse() returns ContextUserCreationResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UserCreationResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class ProductStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Product value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if streamValue is () {
            return streamValue;
        } else if streamValue is grpc:Error {
            return streamValue;
        } else {
            record {|Product value;|} nextRecord = {value: <Product>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextProductStream record {|
    stream<Product, error?> content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderRequest record {|
    placeOrderRequest content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextUserCreationResponse record {|
    UserCreationResponse content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextProductResponse record {|
    ProductResponse content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextCart record {|
    Cart content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type placeOrderRequest record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type User record {|
    string id = "";
    string name = "";
    string role = "";
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type UserCreationResponse record {|
    User[] users = [];
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    string sku = "";
    string status = "";
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type ProductResponse record {|
    string message = "";
    Product product = {};
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type OrderResponse record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type Cart record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: ONLINE_SHOPPING_DESC}
public type CartResponse record {|
    string user_id = "";
|};

