package com.adstream.automate.babylon
package performance.report

import collection.JavaConversions._

case class ReportTest(name: String, enabled: Boolean) {
  var threadingTests: List[ReportThreadingTest] = Nil
  var volumeTests: List[ReportVolumeTest] = Nil
  var degradationTest: Map[Long, Int] = Map.empty
  var complexTests: List[ReportComplexTest] = Nil

  def addDegradation(key: Long, value: Int): Unit = degradationTest += key -> value

  def addThreading(test: ReportThreadingTest): Unit = threadingTests ::= test

  def addVolume(test: ReportVolumeTest): Unit = volumeTests ::= test

  def addComplex(test: ReportComplexTest): Unit = complexTests ::= test

  def javaThreadingTests(): java.util.List[ReportThreadingTest] = threadingTests

  def javaVolumeTests(): java.util.List[ReportVolumeTest] = volumeTests

  def javaDegradationTest(): java.util.Map[java.lang.Long, java.lang.Integer] =
    degradationTest.map(entry => (entry._1: java.lang.Long) -> (entry._2: java.lang.Integer))

  def javaComplexTests(): java.util.List[ReportComplexTest] = complexTests
}
