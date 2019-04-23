package com.adstream.automate.babylon
package performance.tests

import com.adstream.automate.babylon.JsonObjects.Reel
import com.adstream.automate.utils.Gen

class UpdatePresentationTest extends CreatePresentationTest {
  override def beforeStart(): Unit = {
    super.beforeStart()

    val count: Int = 100 - createdPresentations().length

    for (_ <- 1 to count) createPresentation foreach {createdPresentations += _}
  }

  override def start(): Unit = {
    var reel: Reel = getReel
    reel.setName(Gen.getHumanReadableString(8))
    reel = getService.updateReel(reel)
    if (reel == null) fail("Can not update reel")
  }

  private def getReel: Reel = {
    createdPresentations()(Gen.getInt(createdPresentations().length))
  }
}
