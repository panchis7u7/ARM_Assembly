#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// #######################################################################################
// Structure definition.
// #######################################################################################

// Linked List Node definition.

typedef struct Node {
    struct Node* next;
    struct Node* previous;
    char* data;
} Node;

typedef enum ListOperations {
    INSERT_BEGINNING,
    INSERT_LAST
} ListOperations;

// #######################################################################################
// Function prototypes.
// #######################################################################################

void list_insert(Node** head, char* data, ListOperations operation);
void list_free(Node** head);
void list_print(Node** head);

// #######################################################################################
// Entrypoint.
// #######################################################################################

int main(int argc, char* argv[]) {
    (void)argc;
    (void)argv;

    Node* head = {0}; 
    list_insert(&head, "training", INSERT_BEGINNING);
    list_insert(&head, "GDB", INSERT_BEGINNING);
    list_insert(&head, "CATs", INSERT_BEGINNING);

    list_insert(&head, "El", INSERT_LAST);
    list_insert(&head, "Futuro", INSERT_LAST);
    list_insert(&head, "es", INSERT_LAST);
    list_insert(&head, "Hoy,", INSERT_LAST);
    list_insert(&head, " Viejo!", INSERT_LAST);
    
    list_print(&head);
    list_free(&head);

    return 0;
}

void list_insert(Node** head, char* data, ListOperations operation) {

    Node* raw_head = *head;

    // Create a new block and then zero it out.
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->data = data;
    new_node->next = NULL;
    new_node->previous = NULL;

    if (*head == NULL)
        *head = new_node;
        return;

    switch (operation){
        case INSERT_BEGINNING: {
            // Case: Insert at the beginning
            new_node->next = *head;
            (*head)->previous = new_node;
            *head = new_node;
            break;
        }
        
        case INSERT_LAST: {
            // Case: Insert at the end
            Node* last_node = *head;
            while (last_node->next != NULL) {
                last_node = last_node->next;
            }
            new_node->previous = last_node;
            last_node->next = new_node;
            break;
        }
    }

    return;
}

void list_print(Node** head) {
    if (head == NULL) {
        printf("Doubly Linked List: [empty]\n");
        return;
    }

    printf("Doubly Linked List:\n");
    printf(" ┌────────┬─────────┬───────┐\n");
    printf(" │   %s   │", (*head)->data);

    Node* current = (*head)->next;
    while (current != NULL) {
        printf(" → %s   │", current->data);
        current = current->next;
    }

    printf("\n ├───────┼─────────┼───────┤\n");
    printf(" │       ↑       │\n");

    current = (*head)->next;
    while (current != NULL) {
        printf(" │       ↓       │\n");
        printf(" │   %s   │\n", current->data);
        current = current->next;
    }

    printf(" └───────┴─────────┴───────┘\n");
}

void list_free(Node** head) {
    Node* current = *head;
    Node* next;

    while (current != NULL) {
        next = current->next;
        free(current);
        current = next;
    }

    *head = NULL; // Set the head pointer to NULL after freeing all nodesee(temp);
}