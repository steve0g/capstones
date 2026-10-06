// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract MyPhoneStore{
    // owner
    address public owner;

    // struct Phone
    struct Phone{
        string modele;
        uint256 prix;
        bool disponible;
    }

    // tableau des téléphones
    Phone[] public stock;

    // constructor
    constructor() {
        owner = msg.sender;
    }

    // fonction pour ajouter un téléphone
    function ajouterTelephone(string memory _modele, uint256 _prix) public {
        require(msg.sender == owner, "Seul le proprietaire peut effectuer cette action");
        stock.push( Phone(_modele, _prix, true) );
    }

    // fonction pour consulter le prix
    function consulterPrix(uint256 _index) public view returns(uint256) {
        return stock[_index].prix;
    }

    // fonction pour marquer vendu
    function marquerVendu(uint256 _index) public {
        require(msg.sender == owner, "Seul le proprietaire peut effectuer cette action");
        stock[_index].disponible = false;
    }
}