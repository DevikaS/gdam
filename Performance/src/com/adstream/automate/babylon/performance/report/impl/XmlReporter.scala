package com.adstream.automate.babylon
package performance.report.impl

import com.adstream.automate.babylon.performance.report.{ReportTest, Reporter}
import scala.reflect.io.File
import com.adstream.automate.babylon.core.BabylonCoreService

class XmlReporter(private val coreService: BabylonCoreService) extends Reporter {
  private var tests: List[ReportTest] = Nil

  private def writeTeamcityInfoXml(): Unit = {
    val xml =
      <build>
        {for {test <- tests.sortBy(_.name); rt <- test.threadingTests if rt.errorsCount == 0} yield {
          <statisticValue key={s"${test.name}-rps-${rt.threadsCount}"} value={(rt.rps * 100).toInt.toString}/>
            <statisticValue key={s"${test.name}-errors-${rt.threadsCount}"} value={rt.errorsCount.toString}/>
            <statisticValue key={s"${test.name}-hits-${rt.threadsCount}"} value={rt.hitsCount.toString}/>
            <statisticValue key={s"${test.name}-response_time-${rt.threadsCount}"} value={(rt.responseTime * 1000).toInt.toString}/>}}
        {for {test <- tests.sortBy(_.name); rt <- test.volumeTests} yield {
          <statisticValue key={s"${test.name}-rps-${rt.iterationsCount}"} value={(rt.rps * 100).toInt.toString}/>
            <statisticValue key={s"${test.name}-errors-${rt.iterationsCount}"} value={rt.errorsCount.toString}/>
            <statisticValue key={s"${test.name}-hits-${rt.iterationsCount}"} value={rt.hitsCount.toString}/>
            <statisticValue key={s"${test.name}-response_time-${rt.iterationsCount}"} value={(rt.responseTime * 1000).toInt.toString}/>}}
        {for {test <- tests.sortBy(_.name); ct <- test.complexTests} yield {
          <statisticValue key={s"${test.name}-complex-${ct.requestsPerMinute}"} value={(ct.responseTime * 1000).toInt.toString}/>}}
        <statisticValue key="Rebuild Index" value={coreService.getElasticSearchRebuildTime}/>
      </build>

    File("../teamcity-info.xml").writeAll(xml.toString())
  }

  private def writePluginSettingsXml(): Unit = {
    val teamCityBuildTypeId = System.getProperty("teamcity.buildType.id")

    val xml =
      <settings>
        <custom-graphs>
          {for (test <- tests.sortBy(_.name) if test.enabled && test.threadingTests.nonEmpty) yield {
          <graph title={s"${test.name} [Response Time/s]"} hideFilters="" seriesTitle="Thread" format="duration">
            <valueType key={s"${test.name}-response_time-1"} color="DarkGray" title="1 thread" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-2"} color="Aqua" title="2 threads" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-4"} color="ForestGreen" title="4 threads" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-8"} color="DarkViolet" title="8 threads" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-16"} color="HotPink" title="16 threads" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-32"} color="Orange" title="32 threads" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-64"} color="OrangeRed" title="64 threads" buildTypeId={teamCityBuildTypeId}/>
          </graph>
        }}{for (test <- tests.sortBy(_.name) if test.enabled && test.volumeTests.nonEmpty) yield {
          <graph title={s"${test.name} [Response Time/s]"} hideFilters="" seriesTitle="Iteration" format="duration">
            <valueType key={s"${test.name}-response_time-1"} color="DarkGray" title="1 iteration" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-2"} color="Aqua" title="2 iteration" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-3"} color="ForestGreen" title="3 iteration" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-4"} color="DarkViolet" title="4 iteration" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-5"} color="HotPink" title="5 iteration" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-6"} color="Orange" title="6 iteration" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-response_time-7"} color="OrangeRed" title="7 iteration" buildTypeId={teamCityBuildTypeId}/>
          </graph>
        }}{for (test <- tests.sortBy(_.name) if test.enabled && test.complexTests.nonEmpty) yield {
          <graph title={s"${test.name} [Requests Per Minute]"} hideFilters="" seriesTitle="Thread" format="duration">
            <valueType key={s"${test.name}-complex-1500"} color="OrangeRed" title="1500 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-1111"} color="Orange" title="1111 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-833"} color="HotPink" title="833 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-625"} color="DarkViolet" title="625 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-468"} color="ForestGreen" title="468 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-350"} color="Aqua" title="350 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-263"} color="DarkGray" title="263 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-197"} color="GreenYellow" title="197 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-148"} color="LightSkyBlue" title="148 t/m" buildTypeId={teamCityBuildTypeId}/>
            <valueType key={s"${test.name}-complex-111"} color="LightGoldenRodYellow" title="111 t/m" buildTypeId={teamCityBuildTypeId}/>
          </graph>
        }}<graph title="Rebuild Index" hideFilters="" seriesTitle="One" format="duration">
          <valueType key="Rebuild Index" color="ForestGreen" title="duration" buildTypeId={teamCityBuildTypeId}/>
        </graph>
        </custom-graphs>
      </settings>

    File("../plugin-settings.xml").writeAll(xml.toString())
  }

  def writeReport(): Unit = {
    writeTeamcityInfoXml()
    writePluginSettingsXml()
  }

  def addTest(reportTest: ReportTest): Unit = tests ::= reportTest
}
