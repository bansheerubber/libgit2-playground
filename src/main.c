#include <git2.h>
#include <stdio.h>

void check_lg2(int error, const char* message, const char* extra) {
	const git_error *lg2err;
	const char *lg2msg = "", *lg2spacer = "";

	if(!error) {
		return;
	}

	if((lg2err = git_error_last()) != NULL && lg2err->message != NULL) {
		lg2msg = lg2err->message;
		lg2spacer = " - ";
	}

	if(extra) {
		fprintf(stderr, "%s '%s' [%d]%s%s\n", message, extra, error, lg2spacer, lg2msg);
	}
	else {
		fprintf(stderr, "%s [%d]%s%s\n", message, error, lg2spacer, lg2msg);
	}

	exit(1);
}

int lg2_push(git_repository* repo) {
	git_push_options options;
	git_remote* remote = NULL;
	char *refspec = "refs/heads/master";
	const git_strarray refspecs = {
		&refspec,
		1
	};

	check_lg2(git_remote_lookup(&remote, repo, "origin"), "Unable to lookup remote", NULL);
	
	check_lg2(git_push_options_init(&options, GIT_PUSH_OPTIONS_VERSION), "Error initializing push", NULL);

	check_lg2(git_remote_push(remote, &refspecs, &options), "Error pushing", NULL);

	printf("pushed\n");
	return 0;
}

int main(int argc, char** argv) {
	git_libgit2_init();

	git_repository* repo = NULL;
	check_lg2(git_repository_init(&repo, "test-repo", 0), "Unable to open repository", NULL);

	lg2_push(repo);

	git_repository_free(repo);
	
	return 0;
}