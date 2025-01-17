clean:
	rm -Rf public/*
prod:clean
	hugo build -e production
dev:clean
	hugo serve -e development --noHTTPCache --disableFastRender --ignoreCache
