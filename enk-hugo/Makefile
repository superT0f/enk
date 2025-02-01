help:
	@echo "Usage :\n\
	make clean|prod|dev\n"
	@echo "make clean		clean generated content in public folder"
	@echo "make prod		build with for prod env"
	@echo "make dev		serve for dev env"
clean:
	rm -Rf public/*
prod:clean
	hugo build -e production
dev:clean
	hugo serve -e development --noHTTPCache --ignoreCache --disableFastRender
