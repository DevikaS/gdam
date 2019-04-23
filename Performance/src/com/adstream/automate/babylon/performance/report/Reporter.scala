package com.adstream.automate.babylon
package performance.report

trait Reporter {
  def addTest(reportTest: ReportTest): Unit

  def writeReport(): Unit
}
