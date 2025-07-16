import logging;
import traceback;
import from logging { Logger }
import from jivas.agent.core.agent { Agent }
import from jivas.agent.action.interact_action { InteractAction }
import from actions.jivas.langchain_model_action.langchain_model_action { LangChainModelAction }
import from jivas.agent.action.model_action { ModelAction, ModelActionResult }

node UserModelInteractAction(InteractAction) {
    # maintains a descript, conceptual understanding of the user by monitoring conversational exchanges; may be utilized by other actions which adapt the system to user's specific needs.
    # always ensure that this is registered before the final response is generated

    # set up logger
    static has logger:Logger = logging.getLogger(__name__);

    has anchors:list = [
        "The user shares personal information and demographics",
        "The user shares preferences and interests",
        "The user shares behavioral patterns and habits",
        "The user shares personal opinions, values, or beliefs",
        "The user shares goals and needs",
        "Mentions of relationships with family, friends, or colleagues"
    ];

    has prompt:str = "Act as a user model building agent, designed to maintain an updated user model based on user messages and perform the following steps:\n1. Thoroughly assess USER_MESSAGE and HISTORY for details about the user specific to ANCHORS which are relevant to update USER_MODEL.\n2. Using markdown, update USER_MODEL with any new and revised details assessed. Be sure to maintain previous details of USER_MODEL which do not apply to this update or extend it as required.\n3. Output the updated USER_MODEL without markdown delimiters, JSON or explanations!\n\nUSER_MESSAGE:\n---\n{utterance}\n---\n\nHISTORY:\n---\n{history}\n---\n\nANCHORS:\n---\n{anchors}\n---\n\nUSER_MODEL:\n---\n{user_model}\n---";
    has user_model_template:str = "**User Model:**\n- **Personal Information and Demographics:**\n- **Preferences and Interests:**";
    has history:bool = True;
    has history_size:int = 3;
    has max_statement_length:int = 500;
    has model_action:str = "LangChainModelAction";
    has model_name:str = "gpt-4o";
    has model_temperature:float = 0.3;
    has model_max_tokens:int = 2048;

    def touch(visitor: agent_graph_walker) -> bool {

        if (visitor.utterance) {
            return True;
        }
        return False;
    }

    def execute(visitor: agent_graph_walker) -> None {

        # if no user model, let's use the user_model_template as a start...
        if( not (user_model := visitor.frame_node.data_get(key = "user_model")) ) {
            user_model = self.user_model_template;
        }

        prompt_variables = {
            "utterance": visitor.utterance,
            "anchors": self.anchors,
            "user_model": user_model
        };

        # prepare the prompt with utterance
        prompt_messages = [
            {"system": self.prompt},
            {"human": "{utterance}"}
        ];

        if (self.history) {
            # grab the history
            statements = visitor.frame_node.get_transcript_statements(interactions = self.history_size, max_statement_length = self.max_statement_length);
            if (statements) {
                # prepend statements to the prompt messages
                prompt_messages = statements + prompt_messages;
            }
        }


        if(model_action := self.get_agent().get_actions().get(action_label=self.model_action)) {

            if( model_action_result := model_action.call_model(
                prompt_messages = prompt_messages,
                prompt_variables = prompt_variables,
                model_name = self.model_name,
                model_temperature = self.model_temperature,
                model_max_tokens = self.model_max_tokens,
                interaction_node = visitor.interaction_node
            )) {
                # update the user model in the session...
                if(updated_model := model_action_result.get_result()) {
                    visitor.frame_node.data_set(key = "user_model", value = updated_model);
                }
            }
        }

    }


    def healthcheck() -> bool {
        try {
            if(
                self.prompt and
                self.user_model_template and
                self.history_size > 0 and
                self.max_statement_length > 0 and
                self.model_action and
                self.model_name and
                self.model_max_tokens > 0
            ){
                return True;
            }
            return False;
        } except Exception as e {
            self.logger.error(f"An exception occurred in {self.label}:\n{traceback.format_exc()}\n");
            return False;
        }
    }
}
