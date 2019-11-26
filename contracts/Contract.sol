pragma solidity 0.5.8;

contract Asset {
    uint public value;
    uint public pieces;
    mapping(uint => Owner) public tokens;
    uint256 public tokensSold;
    address payable public ownerAddress;


    struct Owner {
        address _address;
    }

    function getTokenPrice() public view returns (uint256){
        uint256 tokenValue = value/pieces;
        return tokenValue;
    }

    function buyToken() public {
        address _address = msg.sender;
        if(tokensSold < pieces){
            tokensSold += 1;
            tokens[tokensSold] = Owner(_address);
            ownerAddress.transfer(getTokenPrice());
        }
    }

    function isOwner(address _address) public view returns (bool, uint256){
        for(uint256 i = 0; i < tokensSold; i += 1) {
            if(_address == tokens[i]._address){
                return (true, i);
            }
        }
        return (false, 0);
    }

    function sellToken() public payable{
        address payable _address = msg.sender;
        (bool _isOwner, uint256 _index) = isOwner(_address);
        if(_isOwner){
            Owner memory last = tokens[tokensSold];
            tokens[_index] = last;
            delete tokens[tokensSold];
            tokensSold -= 1;
            _address.transfer(getTokenPrice());
            
        }
    }
}