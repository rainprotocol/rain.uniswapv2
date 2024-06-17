// THIS FILE IS AUTOGENERATED BY ./script/BuildPointers.sol

// This file is committed to the repository because there is a circular
// dependency between the contract and its pointers file. The contract
// needs the pointers file to exist so that it can compile, and the pointers
// file needs the contract to exist so that it can be compiled.

// SPDX-License-Identifier: CAL
pragma solidity =0.8.25;

/// @dev Hash of the known bytecode.
bytes32 constant BYTECODE_HASH = bytes32(0x3c2f86d843dfb1ec2cac510a87d8a33e1e19513f96f2387af07f15dde5785fc7);

/// @dev The hash of the meta that describes the contract.
bytes32 constant DESCRIBED_BY_META_HASH = bytes32(0x8b5104dd1fbe98ad3ad2842b81a2cef88d09b514802d01dadecf2a9ef8b7e1d9);

/// @dev Encodes the parser meta that is used to lookup word definitions.
/// The structure of the parser meta is:
/// - 1 byte: The depth of the bloom filters
/// - 1 byte: The hashing seed
/// - The bloom filters, each is 32 bytes long, one for each build depth.
/// - All the items for each word, each is 4 bytes long. Each item's first byte
///   is its opcode index, the remaining 3 bytes are the word fingerprint.
/// To do a lookup, the word is hashed with the seed, then the first byte of the
/// hash is compared against the bloom filter. If there is a hit then we count
/// the number of 1 bits in the bloom filter up to this item's 1 bit. We then
/// treat this a the index of the item in the items array. We then compare the
/// word fingerprint against the fingerprint of the item at this index. If the
/// fingerprints equal then we have a match, else we increment the seed and try
/// again with the next bloom filter, offsetting all the indexes by the total
/// bit count of the previous bloom filter. If we reach the end of the bloom
/// filters then we have a miss.
bytes constant PARSE_META =
    hex"010000000000040000000000008800000000020000a0000000000000000000000000059852a103fd758204722c3102fe814f01b519ad007b1e62";

/// @dev The build depth of the parser meta.
uint8 constant PARSE_META_BUILD_DEPTH = 1;

/// @dev Real function pointers to the sub parser functions that produce the
/// bytecode that this contract knows about. This is both constructing the subParser
/// bytecode that dials back into this contract at eval time, and mapping
/// to things that happen entirely on the interpreter such as well known
/// constants and references to the context grid.
bytes constant SUB_PARSER_WORD_PARSERS = hex"0cee0d100d230d360d490d5c";

/// @dev Every two bytes is a function pointer for an operand handler.
/// These positional indexes all map to the same indexes looked up in the parse
/// meta.
bytes constant OPERAND_HANDLER_FUNCTION_POINTERS = hex"1f601f601f601fc51fc51fc5";

/// @dev The function pointers for the integrity check fns.
bytes constant INTEGRITY_FUNCTION_POINTERS = hex"1d731d731d831d931d931d9f";

/// @dev The function pointers known to the interpreter for dynamic dispatch.
/// By setting these as a constant they can be inlined into the interpreter
/// and loaded at eval time for very low gas (~100) due to the compiler
/// optimising it to a single `codecopy` to build the in memory bytes array.
bytes constant OPCODE_FUNCTION_POINTERS = hex"0e000fa6114c13a415ff180b";

/// @dev Every two bytes is a function pointer for a literal parser.
/// Literal dispatches are determined by the first byte(s) of the literal
/// rather than a full word lookup, and are done with simple conditional
/// jumps as the possibilities are limited compared to the number of words we
/// have.
bytes constant LITERAL_PARSER_FUNCTION_POINTERS = hex"1f57";
