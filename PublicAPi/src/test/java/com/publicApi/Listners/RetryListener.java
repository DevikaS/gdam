/**
 * 
 */
package com.publicApi.Listners;

import org.testng.annotations.ITestAnnotation;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;

import org.testng.IAnnotationTransformer;
import org.testng.IRetryAnalyzer;

/**
 * @author Laxmi.Somni
 *
 */
public class RetryListener implements IAnnotationTransformer  {

	
	public void transform(ITestAnnotation testannotation, Class testClass,
			Constructor testConstructor, Method testMethod){
		
		IRetryAnalyzer retry = testannotation.getRetryAnalyzer();

		if (retry == null)	{
			testannotation.setRetryAnalyzer(Retry.class);
		}
		
	}
}
