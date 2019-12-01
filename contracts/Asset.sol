pragma solidity >=0.5.8;

contract Asset {
    uint public value;
    uint public pieces;
    mapping(uint => Owner) public tokens;
    uint256 public tokensSold = 0;
    address payable public ownerAddress;
    
    constructor(
        uint _value,
        uint _pieces,
        address payable _beneficiary
    ) public {
        value = _value;
        pieces = _pieces;
        ownerAddress = _beneficiary;
    }


    struct Owner {
        address _address;
    }

    function getTokenPrice() public view returns (uint256){
        uint256 tokenValue = value/pieces;
        return tokenValue;
    }

    // function buyToken() private payable {
    //     address _address = msg.sender;
    //     if(tokensSold < pieces){
    //         tokens[tokensSold] = Owner(_address);
    //         tokensSold += 1;
    //         ownerAddress.transfer(getTokenPrice());
    //     }
    // }

    function buyTokens(uint256 _tokens) public payable {
        address _address = msg.sender;
        if(tokensSold + _tokens < pieces){
            for(uint256 i = tokensSold; i < tokensSold + _tokens; i += 1){
                tokens[i] = Owner(_address);
            }
            ownerAddress.transfer(getTokenPrice() * _tokens);
            tokensSold += _tokens;
        }
    }
    

    function isOwner(address _address) public view returns (bool, uint256){
        for(uint256 i = 0; i <= tokensSold; i += 1) {
            if(_address == tokens[i]._address){
                return (true, i);
            }
        }
        return (false, 0);
    }

    function sellTokens(uint256 _tokens) public payable{
        address payable _address = msg.sender;
        uint256 counter = 0;
        for(uint256 i = 0; i < _tokens; i += 1) {
            bool available = deleteToken();
            if(available){
                counter += 1;
            }
            else{
                break;
            }
        }
        _address.transfer(getTokenPrice() * counter);
    }

    function deleteToken() private returns (bool){
        address payable _address = msg.sender;
        (bool _isOwner, uint256 _index) = isOwner(_address);
        if(_isOwner){
            Owner memory last = tokens[tokensSold];
            tokens[_index] = last;
            delete tokens[tokensSold];
            tokensSold -= 1;
            return true;
        }
    }
}