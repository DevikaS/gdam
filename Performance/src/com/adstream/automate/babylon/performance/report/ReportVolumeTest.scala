package com.adstream.automate.babylon
package performance.report

import scala.collection.JavaConversions._

case class ReportVolumeTest(
                                iterationsCount: Int,
                                rps: Double,
                                hitsCount: Int,
                                errorsCount: Int,
                                responseTime: Double,
                                partialTimes: Map[String, Long]
                                ) {
  def partialTimesJavaKeySet: java.util.Set[String] = partialTimes.keySet
}

object ReportVolumeTest {
  def apply(iterationsCount: Int,
            rps: Double,
            hitsCount: Int,
            errorsCount: Int,
            responseTime: Double,
            partialTimes: java.util.Map[String, java.lang.Long]): ReportVolumeTest =
    new ReportVolumeTest(
      iterationsCount, rps, hitsCount,
      errorsCount, responseTime,
      partialTimes.map(entry => entry._1 -> entry._2.toLong).toMap
    )
}