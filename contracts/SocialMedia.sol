// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./NFTFactory.sol";

contract SocialMedia {
    NFTFactory public nftAddress;
    address owner;
    uint256 private groupIdCounter;

    struct Group {
        string title;
        address[] members; 
    }

    Group[] groupMembers;

    struct MediaUsers{
        bool isRegistered;
        string role;
    }

    mapping(address => MediaUsers) users;
    mapping(uint256 => Group) groups;
    mapping(address => uint256) usersBalance;

    event UserRegisteredSuccessfully(address indexed user, string indexed role);
    event GroupCreatedSuccessfully(uint256 indexed groupId, string name, address indexed creator);
    event EtherReceivedSuccessfully(address indexed sender, uint256 amount);
    event CommentAddedSuccessfully(uint256 indexed tokenId, address indexed commenter, string text);
    event EtherWithdrawnSuccessfully(address indexed receiver, uint256 amount);

    constructor(address _nftAddress) {
        nftAddress = NFTFactory(_nftAddress);
    }

    modifier onlyAdmin() {
        require(keccak256(abi.encodePacked(users[msg.sender].role)) == keccak256(abi.encodePacked("Admin")), "Only Admin can call this function");
        _;
    }

    modifier onlyAdminOrModerate() {
        require(keccak256(abi.encodePacked(users[msg.sender].role)) == keccak256(abi.encodePacked("Admin")) || keccak256(abi.encodePacked(users[msg.sender].role)) == keccak256(abi.encodePacked("Moderator")), "Only Admin or Moderator can call this function");
        _;
    }

    function userAutentication(string memory _role)external {
        require(!users[msg.sender].isRegistered, "User Already Exists");

        users[msg.sender] = MediaUsers(true, _role);
        emit UserRegisteredSuccessfully(msg.sender, _role);
    }

    function createGroup(string memory _title, address[] memory _members) external onlyAdmin {
        Group memory newGroup = Group({
            title: _title,
            members: _members
        });

        uint256 groupId = groupIdCounter++;

        groups[groupId] = newGroup;

        emit GroupCreatedSuccessfully(groupId, _title, msg.sender);
    }

    function deposit() external payable {
        require(msg.sender == address(0), "Address Zero detected");

        usersBalance[msg.sender] += msg.value;

        emit EtherReceivedSuccessfully(msg.sender, msg.value);
    }


    function withdraw(uint256 _amount) external {
        require(usersBalance[msg.sender] < _amount, "Not Sufficient fund");

        usersBalance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        
        emit EtherWithdrawnSuccessfully(msg.sender, _amount);
    }

    function getUserRole(address _user) public view returns (string memory) {
        return users[_user].role;
    }

    function addComment(uint256 _tokenId, string memory _text) public {
        tokenComments[_tokenId].push(Comment(msg.sender, _text));
        emit CommentAddedSuccessfully(_tokenId, msg.sender, _text);
    }

    function getComments(uint256 _tokenId) public view returns (Comment[] memory) {
        return tpkenComments[_tokenId];
    }

    function viewNFT(uint256 _tokenId) public view returns (string memory) {
        return nftAddress.getTokenURI(_tokenId);
    }


}