import XCTest
@testable import AudioPlayer

class TestStatePaused:XCTestCase {
    private var state:StateProtocol!
    private var player:Player!
    private var provider:MockProviderProtocol!
    private var delegate:MockPlayerDelegate!
    
    override func setUp() {
        super.setUp()
        self.state = StatePaused()
        self.player = Player()
        self.provider = MockProviderProtocol()
        self.delegate = MockPlayerDelegate()
        self.player.state = self.state
        self.player.provider = self.provider
        self.player.delegate = self.delegate
    }
    
    func testPauseThrows() {
        XCTAssertThrowsError(try self.state.pause(context:self.player), "Failed to throw")
    }
    
    func testStopChangesStateToStopped() {
        XCTAssertNoThrow(try self.player.stop(), "Failed to stop")
        XCTAssertEqual(self.player.currentState, State.stopped)
    }
    
    func testStopCallsProviderStop() {
        let expect:XCTestExpectation = self.expectation(description:"Play not called")
        self.provider.onStop = { expect.fulfill() }
        XCTAssertNoThrow(try self.player.stop(), "Failed to play")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testStopCallsStateOnDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not called")
        self.delegate.onStatusStopped = { expect.fulfill() }
        XCTAssertNoThrow(try self.player.stop(), "Failed to play")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testPlayChangesStateToPlaying() {
        XCTAssertNoThrow(try self.player.play(), "Failed to stop")
        XCTAssertEqual(self.player.currentState, State.playing)
    }
    
    func testPlayCallsProviderPlay() {
        let expect:XCTestExpectation = self.expectation(description:"Play not called")
        self.provider.onPlay = { expect.fulfill() }
        XCTAssertNoThrow(try self.player.play(), "Failed to play")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testPlayCallsStateOnDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Delegate not called")
        self.delegate.onStatusPlaying = { expect.fulfill() }
        XCTAssertNoThrow(try self.player.play(), "Failed to play")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
    
    func testSeekCallsProviderSeek() {
        let expect:XCTestExpectation = self.expectation(description:"Seek not called")
        self.provider.onSeek = { expect.fulfill() }
        XCTAssertNoThrow(try self.player.seek(seconds:0), "Failed to seek")
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
