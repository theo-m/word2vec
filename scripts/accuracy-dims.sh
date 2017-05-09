#!/bin/bash

TEXT_DATA=../../data/train/text8
VECTOR_DATA=embeddings/text8.bin

for i in 100 200 500 750
do
    echo -------- dim: $i --------
    echo -------- train
    bin/word2vec                            \
        -train ../../data/train/text8       \
        -output embeddings/text8-$i.bin     \
        -size $i                            \
        -window 5                           \
        -sample 0                           \
        -hs 0                               \
        -negative 5                         \
        -threads 12                         \
        -read-vocab vocabs/text8.vocab      \
        -binary 1
    echo -------- test
    bin/compute-accuracy embeddings/text8-$i.bin 30000 < ../../data/test/questions-words.txt
done
