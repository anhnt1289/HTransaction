```mermaid
graph TD
    A[Start] --> B[Validate Email existing];
    B --> C{Throws ERR_100};
    C -- Yes --> D[End]:::error;
    C -- No --> E[Save new user];
    E --> F[Return user saved];
    F --> D;
