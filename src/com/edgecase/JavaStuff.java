package com.edgecase;

import java.util.Random;

class JavaStuff{
    public static final Random GENERATOR = new Random(System.currentTimeMillis());
    public static final int DEFAULT_MAX  = 100;

    public JavaStuff(){}

    public int randomNumber(){
        return randomNumber(DEFAULT_MAX);
    }

    public int randomNumber(int max){
        return GENERATOR.nextInt(max) + 1;
    }
}
