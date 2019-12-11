# Implementing a Calculator

## Introduction

Ultimately, the goal is to display how to make a calculator with a 7-segments display showing :

* The result of the function applied on the two left digits ;
* The two numbers being computed on the two right digits.

It is specified to use switch buttons to choose the function and push buttons to choose which
numbers to compute.

## Specs

It counts five inputs : a clock, two push buttons and two switch buttons. It counts two outputs : one to choose the segment to be lit up, the other to choose the digit that should display the number chosen. The counter allows to choose the digit on which a number should be displayed. It counts from zero to four then resets, allowing to select the Digit one is writing on as well as what one is writing in the said digit.

## Functions

The calculator should be able to perform an addition, a subtraction and a product. The two numbers we operate on are defined by the push buttons. Each time one presses a button, both numbers increments by 1 from 0 to 9. The functions are selected thanks to the switches :

* Addition : not(SW0) and not(SW1) ;
* Subtraction : SW0 and not(SW1) ;
* Multiplication : SW1.

## Results

[Link to the presentation video of the simple Calculator](https://drive.google.com/file/d/1mY_p43W3k9Dpn8Y2KesNBt6lGjn3dmty/view)

