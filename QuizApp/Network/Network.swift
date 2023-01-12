import Foundation
import Network

final class Network: ObservableObject {

    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")

    @Published var isDisconnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isDisconnected = path.status == .satisfied ? false : true
            }
        }
        monitor.start(queue: queue)
    }

}
