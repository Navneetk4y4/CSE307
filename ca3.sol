// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedMarketplace {
    struct Item {
        uint256 id;
        address seller;
        string name;
        uint256 price;
        bool isSold;
    }

    uint256 public itemCount;
    mapping(uint256 => Item) public items;

   
    event ItemListed(uint256 id, address seller, string name, uint256 price);
   
    event ItemPurchased(uint256 id, address buyer, uint256 price);

    function listItem(string memory _name, uint256 _price) external {
        require(_price > 0, "Price must be greater than zero");

        itemCount++;
        items[itemCount] = Item(itemCount, msg.sender, _name, _price, false);

        emit ItemListed(itemCount, msg.sender, _name, _price);
    }

    
    function purchaseItem(uint256 _itemId) external payable {
        Item storage item = items[_itemId];

        require(item.id > 0, "Item does not exist");
        require(!item.isSold, "Item is already sold");
        require(msg.value == item.price, "Incorrect payment amount");

      
        item.isSold = true;

       
        payable(item.seller).transfer(msg.value);

       
        emit ItemPurchased(_itemId, msg.sender, item.price);
    }
}
