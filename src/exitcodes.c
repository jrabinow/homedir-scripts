#include <errno.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef __linux__
#include <closeout.h>
#endif

typedef struct {
  int optind;
  int n;
} ParsedArgs;

void usage(const char *progname, FILE *stream) {
  fprintf(stream,
          "Usage: %s [OPTION]...[CODE]\n"
          "\t-h, --help\tdisplay this help message\n"
          "\t-n\t\tmax exit code\n",
          progname);
}

ParsedArgs parse_args(int argc, char *argv[]) {
  ParsedArgs parsed_args = {0, 130};
  int c, option_index = 0;

  static struct option longopts[] = {
      {"help", no_argument, NULL, 'h'},
      /*
          {"foo-opt", required_argument, NULL, 'f'},
          {"bar-opt", optional_argument, &check_optarg, 12345},
      */
      {NULL, 0, NULL, 0}};

  while ((c = getopt_long(argc, argv, "hn:", longopts, &option_index)) != -1) {
    switch (c) {
    case 'h':
      usage(argv[0], stdout);
      exit(EXIT_SUCCESS);
    case 'n': {
      parsed_args.n = atoi(optarg);
    } break;
    case ':':
      fputs("missing argument", stderr);
    default:
      usage(argv[0], stderr);
      exit(EXIT_FAILURE);
    }
  }
  parsed_args.optind = optind;

  return parsed_args;
}

int main(int argc, char *argv[]) {
  int i = 0, exitcode = -1;
  const char *errmsg = NULL;

#ifdef __linux__
  atexit(close_stdout);
#endif

  ParsedArgs parsed_args = parse_args(argc, argv);
  argc -= parsed_args.optind;
  argv += parsed_args.optind;

  if (argv[0] != NULL) {
    exitcode = atoi(argv[0]);
  }

  if (exitcode != -1) {
    errmsg = strerror(exitcode);
    printf("%3d: %s\n", exitcode, errmsg);
  } else {
    for (i = 1; i <= parsed_args.n; i++) {
      errmsg = strerror(i);
      printf("%3d: %s\n", i, errmsg);
    }
  }
  return 0;
}
