// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract SocialMedia {

    address owner;

    struct Group {
        uint256 id;
        string title;
        string description;
        address[] members; 
    }

    Group[] groupMembers;

    struct MediaUserss{
        bool isRegistered;
        string role;
    }

    function userAutentication(string memory _role)external {
        require(!users[meg.msg.sender].isRegistered, "User Already Exists");
    }
}