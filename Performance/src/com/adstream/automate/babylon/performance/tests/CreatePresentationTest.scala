package com.adstream.automate.babylon
package performance.tests

import com.adstream.automate.babylon.JsonObjects.Reel
import com.adstream.automate.utils.Gen

import scala.collection.mutable.ArrayBuffer

class CreatePresentationTest extends AbstractPerformanceTestServiceWrapper {
  override def runOnce(): Unit = {}

  override def beforeStart(): Unit = logIn(getParam("login"), getParam("password"))

  override def start(): Unit = {
    createPresentation().fold(fail("Can not create presentation"))(addPresentation)
  }

  override def afterRun(): Unit = {}

  protected def createPresentation(): Option[Reel] = {
    val presentation: Reel = new Reel
    presentation.setName(Gen.getHumanReadableString(8))
    presentation.setDescription(Gen.getHumanReadableString(8))
    Option(getService.createReel(presentation))
  }

  protected def addPresentation(presentation: Reel): Unit = createdPresentations += presentation

  protected def createdPresentations(): ArrayBuffer[Reel] = CreatePresentationTest.reels
}

object CreatePresentationTest {
  val reels: ArrayBuffer[Reel] = ArrayBuffer.empty
}
