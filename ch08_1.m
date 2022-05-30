clc; clear; close all;
sig = repmat([3 3 1 3 3 3 3 3 2 3], 1, 50);
symbols = [1 2 3];
p = [0.1 0.1 0.8];
dict = huffmandict(symbols, p);
hcode = huffmanenco(sig, dict);
dhsig = huffmandeco(hcode, dict);
