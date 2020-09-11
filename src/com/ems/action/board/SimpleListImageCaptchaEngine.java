package com.ems.action.board;

import com.octo.captcha.component.image.backgroundgenerator.BackgroundGenerator;
import com.octo.captcha.component.image.backgroundgenerator.GradientBackgroundGenerator;
import com.octo.captcha.component.image.color.SingleColorGenerator;
import com.octo.captcha.component.image.fontgenerator.FontGenerator;
import com.octo.captcha.component.image.fontgenerator.RandomFontGenerator;
import com.octo.captcha.component.image.textpaster.DecoratedRandomTextPaster;
import com.octo.captcha.component.image.textpaster.TextPaster;
import com.octo.captcha.component.image.textpaster.textdecorator.BaffleTextDecorator;
import com.octo.captcha.component.image.textpaster.textdecorator.LineTextDecorator;
import com.octo.captcha.component.image.textpaster.textdecorator.TextDecorator;
import com.octo.captcha.component.image.wordtoimage.ComposedWordToImage;
import com.octo.captcha.component.image.wordtoimage.WordToImage;
import com.octo.captcha.component.word.wordgenerator.RandomWordGenerator;
import com.octo.captcha.component.word.wordgenerator.WordGenerator;
import com.octo.captcha.engine.image.ListImageCaptchaEngine;

import com.octo.captcha.image.gimpy.GimpyFactory;

import java.awt.Color;
import java.awt.Font;


public class SimpleListImageCaptchaEngine extends ListImageCaptchaEngine 
{
    protected void buildInitialFactories() 
    {
        WordGenerator wordGenerator = new RandomWordGenerator("1234567890");
        
        SingleColorGenerator scg = new SingleColorGenerator(Color.blue);
        
        LineTextDecorator lineDecorator = new LineTextDecorator(1, Color.blue);
        
        TextDecorator[] textdecorators = new TextDecorator[1];
        
        textdecorators[0] = lineDecorator;
        
        
        TextPaster textPaster = new DecoratedRandomTextPaster(   
        		new Integer(30), new Integer(5), scg,   
                new TextDecorator[] { new BaffleTextDecorator(new Integer(1), Color.white) }); 
        
        

        
        
        
        BackgroundGenerator backgroundGenerator = 
          new GradientBackgroundGenerator(new Integer(220), new Integer(60), 
          Color.white, Color.GRAY);//width,height
        
        
        // 글꼴 설정
        Font[] fontsList = new Font[] { 
                new Font("Arial", 0, 10), 
                new Font("Tahoma", 0, 10), 
                new Font("Verdana", 0, 10)
        };
        
        FontGenerator fontGenerator = 
          new RandomFontGenerator(new Integer(30), new Integer(35),fontsList);
        
        
        WordToImage wordToImage = 
         new ComposedWordToImage(fontGenerator, backgroundGenerator, textPaster); 
        this.addFactory(new GimpyFactory(wordGenerator,wordToImage));
    }
}


