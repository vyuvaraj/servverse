module e2e

go 1.26.4

require (
	servgate v0.0.0
	servqueue v0.0.0
	servstore v0.0.0
)

replace (
	servgate => ../../ServGate
	servqueue => ../../ServQueue
	servstore => ../../ServStore
)
