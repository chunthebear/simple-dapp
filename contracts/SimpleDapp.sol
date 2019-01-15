pragma solidity ^0.5.0;
contract simpleDapp{
    address Admin;

    /*mapping(bytes32=>notarizedImage) notarizedImage;
    bytes32[] imagesByNotaryHash;
    */
    mapping(address=>User) users;
    address[] usersByAddress;

    /*struct notarizedImage{
        string imageURL;
        uint timeStamp;
    }*/

    struct User{
        string name;
        string city;
        string country;
        //bytes32[] myImages;
    }

    constructor() payable public {  //CONSTRUCTOR gets called ONCE only when contract is first deployed
        Admin = msg.sender;  // just set the admin, so they can remove bad users or images if needed, but nobody else can
    }

    modifier onlyAdmin() {
        require(Admin==msg.sender, "Sender is not admin");
        _; // Do not forget the "_;"! It will be replaced by the actual function body when the modifier is used.
    }

    function register(string memory name, string memory city, string memory country) public{
        address newAddress = msg.sender;

        users[newAddress].name = name;
        users[newAddress].city = city;
        users[newAddress].country = country;
        usersByAddress.push(newAddress);
    }

    function getUsers() public view returns (address[] memory){
        return usersByAddress;
    }

    function getUser (address userAddress) public view returns (string memory, string memory , string memory ){
        return (users[userAddress].name, users[userAddress].city, users[userAddress].country);
    }

}
