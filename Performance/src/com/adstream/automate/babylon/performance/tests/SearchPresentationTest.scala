package com.adstream.automate.babylon
package performance.tests

import com.adstream.automate.babylon.JsonObjects.{Reel, SearchResult}

class SearchPresentationTest extends CreatePresentationTest {
  override def beforeStart(): Unit = {
    super.beforeStart()

    val reelsCount: Int = getParamInt("reelsCount") - createdPresentations().length

    for (_ <- 1 to reelsCount) createPresentation() foreach addPresentation
  }

  override def start(): Unit = {
    val result: SearchResult[Reel] = getService.findReels(new LuceneSearchingParams)
    if (result.getResult.size == 0) {
      fail("Error while searching reels")
    }
  }
}
