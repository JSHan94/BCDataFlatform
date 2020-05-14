pragma solidity ^0.6.6;

contract TradingPlatform{
    
    // token
    mapping (address => uint256) public balanceOf;
    event Buy(address _from,address _to, uint _datah);
    event Balance(address _from, uint _balance);
    event Upload(string _category, string _name, uint _datah, uint _price);
    event GetData(uint timestamp, string category, string name, uint datah, uint price, STATE state, address owner, address buyer);
    
    // data plaform
    enum STATE{ SALES, PROCESSING, SOLDOUT}
    
    struct Data{
        uint timestamp;
        string category;
        string name;
        uint datah;
        uint price;
        STATE state;
        address owner;
        address buyer;
    }
    
    mapping(uint=>Data) data_list;
    
    Data newData;

    function giveToken(uint _token) public {
        balanceOf[msg.sender] += _token;
        
        emit Balance(msg.sender, balanceOf[msg.sender] );
    }
    
    function upload(string memory _category, string memory _name, uint _datah, uint _price) public{
        emit Upload(_category, _name, _datah, _price);
        
        newData.timestamp = now;
        newData.category = _category;
        newData.name = _name;
        newData.datah = _datah; 
        newData.price = _price;
        newData.state = STATE.SALES;
        newData.owner = msg.sender;
        data_list[_datah] = newData;
        
        
    }
    
    
    function buy(uint _datah) public payable {

        Data memory data = data_list[_datah];
        /*
        require(data_list[_datah].owner != address(0)); //check exist Data
        require(balanceOf[msg.sender] >= data.price); // buyer has money
        require(data.owner != msg.sender ); // buyer != owner
        require(data.state == STATE.SALES); //data on sale
        require(data.buyer == address(0)); // no buyer yet
        */
        
        balanceOf[msg.sender] -= data.price; // buyer pay money
        balanceOf[data.owner] += data.price; // owner get money 
        emit Buy(data.owner,msg.sender,_datah);
        
        
        //update data information
        data_list[_datah].buyer = msg.sender;
        data_list[_datah].state = STATE.PROCESSING;
        
    }
    
    function salesConfirm(uint _datah) public{
        
        require(data_list[_datah].owner == msg.sender );
        require(data_list[_datah].state == STATE.PROCESSING);
    
        data_list[_datah].state = STATE.SOLDOUT;
        
    }
    
    
    function getData(uint _datah) public{
        Data memory data = data_list[_datah];
        
        emit GetData(data.timestamp, data.category, data.name, data.datah, data.price, data.state, data.owner, data.buyer);
    }
    
    
    
}

