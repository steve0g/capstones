// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract MyBookStore {
    // propriétaire
    address public owner;

    // structure Book
    struct Book{
        string title;
        uint256 price;
        bool available;
    }

    // tableau permettant de stocker plusieurs livres
    Book[] public stock;

    // constructor
    constructor() {
        owner = msg.sender;
    }

    // permettre uniquement au propriétaire d'ajouter un livre
    function addBook(string memory _title, uint256 _price) public {
        require(msg.sender == owner, "Only owner can add book");
        stock.push( Book(_title, _price, true) );
    }

    // permettre à n'importe qui de consulter le prix d'un livre avec son index
    function checkBookPrice(uint256 _index) public view returns(uint256 _price) {
        return stock[_index].price;
    }

    // permettre uniquement au propriétaire de marquer un livre comme indisponible
    function markUnavailable(uint256 _index) public {
        require(msg.sender == owner, "Only onwer can do that");
        stock[_index].available = false;
    }

    // permettre à n'importe qui de compter combien de livres sont actuellement disponibles.
    function bookAvailable() public view returns(uint256) {
        uint256 compteur = 0;
        for (uint256 i = 0; i < stock.length; i++) {
            if (stock[i].available == true) {
                compteur++;
            }
        }
        return compteur;
    }
}