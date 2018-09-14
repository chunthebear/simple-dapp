pragma solidity ^0.4.4;
contract SimpleDapp{
	address Admin;

	/*mapping(bytes32=>notarizedImage) notarizedImage;
	bytes32[] imagesByNotaryHash;
	*/
	mapping(address=>User) Users;
	address[] usersByAddress;

	/*struct notarizedImage{
		string imageURL;
		uint timeStamp;
	}*/

	struct User{
		string name;
		bytes32 city;
		bytes32 country;
		//bytes32[] myImages;
	}

	function SimpleDapp() payable {  //CONSTRUCTOR gets called ONCE only when contract is first deployed
	    Admin = msg.sender;  // just set the admin, so they can remove bad users or images if needed, but nobody else can
	 }

	modifier onlyAdmin() {
    if (msg.sender != Admin)
      throw;
    _; // Do not forget the "_;"! It will be replaced by the actual function body when the modifier is used.
  }

	function register(string name, bytes32 city, bytes32 country) returns(bool success){
		address newAddress = msg.sender;

		if(bytes(Users[newAddress].name).length==0 && bytes(name).length!=0){
			Users[newAddress].name = name;
			Users[newAddress].city = city;
			Users[newAddress].country = country;
			usersByAddress.push(newAddress);
			return true;
		} else{
			return false;
		}
	}

	function getUsers() constant returns (address[]){
		return usersByAddress;
	}

	function getUser (address userAddress) constant returns (string, bytes32, bytes32){
		return (Users[userAddress].name, Users[userAddress].city, Users[userAddress].country);
	}

}
