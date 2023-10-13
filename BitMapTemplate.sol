// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.20;

contract BitMap  {


   uint256 public bitmap;




    function getValueInByte(uint8 index, uint256 bitmap) public pure returns (uint8) {
        require(index < 32, "Invalid index"); // Ensure index is within bounds
        //reverse index order
        index = 31 - index;
        bytes32 bitmapBytes = bytes32(bitmap);
        uint8 byteValue = uint8(bitmapBytes[index]);
        return byteValue;
    }

    function getAllNumbers(uint256 bitmap) public pure returns (uint8[32] memory) {
        uint8[32] memory numbers;
        for (uint8 i = 0; i < 32; i++) {
            numbers[i] = getValueInByte(i, bitmap);
        }
        return numbers;
    }


     function getAllNumbersB() public view returns (uint8[32] memory) {
        uint8[32] memory numbers;
        for (uint8 i = 0; i < 32; i++) {
            numbers[i] = getValueInByte(i, bitmap);
        }
        return numbers;
    }

    function getSelectedNumbers(uint8[] memory bytePositions, uint256 bitmap) public pure returns (uint8[] memory) {
        uint8[] memory selectedNumbers = new uint8[](bytePositions.length);

        for (uint256 i = 0; i < bytePositions.length; i++) {
            selectedNumbers[i] = getValueInByte(bytePositions[i], bitmap);
        }

        return selectedNumbers;
    }


//     function storeValueInBitmap(value: number, position: number, bitmap: any) {
//   bitmap &= ~(BigInt(0xff) << (BigInt(position) * BigInt(8)));

//   // Set the value in the specified position
//   bitmap |= BigInt(value) << (BigInt(position) * BigInt(8));

//   return bitmap;
// }

function store(uint8 value,uint8 position) public  returns(uint256){
 require(position < 32, 'Can only store up to 32');

        uint256 mask = uint256(0xff) << (position * 8); // Create a mask for the position
        uint256 invertedMask = ~mask; // Invert the mask

        bitmap &= invertedMask; // Clear the bits at the position
        uint256 valueToStore = uint256(value) << (position * 8); // Shift the value to the correct position
        bitmap |= valueToStore; // Set the bits with the value

        return bitmap;
}
}
