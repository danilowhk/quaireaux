//! Stack implementation.
//!
//! # Example
//! ```
//! use quaireaux::data_structures::stack::StacTrait;
//!
//! // Create a new stack instance.
//! let mut stack = StacTrait::new();
//! # TODO: Add example code for the different methods.

// Core lib imports
use dict::DictFeltToTrait;
use dict::SquashedDictFeltTo;
// use array::ArrayTrait;

//! Stack module
/// Stack representation.
// #[derive(Drop, Copy)]
struct Stack {
    //TODO: Question, do we need "word_dict_start" in CairoV1?
    word_dict: DictFeltTo::<u256>,
    len: felt,
}

// // #[derive(Drop, Copy)]
struct Summary {
    squashed_end: SquashedDictFeltTo::<u256>,
    len: felt,
}

trait StackTrait {
    fn new() -> Stack;
    fn push(ref self: Stack, value: u256);
    fn pop(ref self: Stack) -> Option::<u256>;
    fn peek(ref self: Stack, idx: felt) -> Option::<u256>;
    fn get_len(ref self: Stack) -> felt;
    fn swap_i(ref self: Stack, i: felt);
    fn finalize(ref self: Stack) -> Summary;
}
impl StackImpl of StackTrait {
    // Stack New Function
    fn new() -> Stack {
        let new_word_dict = DictFeltToTrait::<u256>::new();
        Stack { word_dict: new_word_dict, len: 0  }
    }

    // Stack Push function
    fn push(ref self: Stack, value: u256) {

        let Stack { mut word_dict, mut len } = self;      
        //TODO: Overflow check?

        //Insert new value to Stack
        word_dict.insert(len, value);
        len = len + 1;
        self = Stack { word_dict, len };
    }

    //Stack Pop Function
    fn pop(ref self: Stack) -> Option::<u256> {
        let Stack{word_dict: mut word_dict, len: mut len } = self;
     
        //TODO: Fix if statement
        if len < 0 {
            self = Stack { word_dict, len };
            return Option::None(());
        }

        // Get "value" at index "len"      
        let value = word_dict.get(len);
        len = len - 1;
        self = Stack { word_dict, len };

    //     //Return value
        return Option::Some(value);
            // return Option::None(());

    }

    fn peek(ref self: Stack, index: felt) -> Option::<u256> {
        let Stack{word_dict: mut word_dict, len: mut len } =
            self;
    
        // Check if index is within len
        // if len < index {
        //     return Option::<T>::None(());
        // }
        // Get "value" at "index"
        let value = word_dict.get(index);

        self = Stack { word_dict, len };

        // Return value
        return Option::Some(value);
    }

    fn get_len(ref self: Stack) -> felt {
        let Stack{word_dict: mut word_dict, len: mut len } =
            self;
        self = Stack { word_dict, len };
        len
    }

    fn swap_i(ref self: Stack, i: felt) {
        let Stack { word_dict: mut word_dict, len: len } = self;

        let i_index = len - i;
        // TODO: How to just end the function?
        // if len < i {
        //     self = Stack { word_dict, len };
        // }
        // Get "values" to "swap"
        let value_i = word_dict.get(i_index);
        let value_len = word_dict.get(len);
        // "Swap" value
        word_dict.insert(len, value_i);
        word_dict.insert(i_index, value_len);
        self = Stack { word_dict, len };
    }

    fn finalize(ref self: Stack) -> Summary {
        let Stack{ word_dict: word_dict, len: mut len } = self;

        // Finalize dict
        let word_dict_finalized = word_dict.squash();
        // TODO: How to drop self, withouth the need to create another dict?
        let word_dict_2 = DictFeltToTrait::<u256>::new();
        self = Stack { word_dict : word_dict_2, len };

        Summary {
            squashed_end: word_dict_finalized, len
        }
    }
}
// impl Array2DU8Drop of Drop::<Array::<Array::<u8>>>;
// impl Array2DU8Copy of Copy::<Array::<Array::<u8>>>;
// impl QueueFeltDrop of Drop::<Stack::<felt>>;



